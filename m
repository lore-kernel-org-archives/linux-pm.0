From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [regression,
	bisected] adb trackpad disappears after suspend to ram
Date: Wed, 3 Jun 2009 12:02:27 +0200
Message-ID: <200906031202.28916.rjw@sisk.pl>
References: <878wkl6vce.fsf@scholz.fias.uni-frankfurt.de>
	<200906011836.15507.rjw@sisk.pl>
	<877hzv8txp.fsf@scholz.fias.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4052088718061590868=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <877hzv8txp.fsf@scholz.fias.uni-frankfurt.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jan Scholz <scholz@fias.uni-frankfurt.de>
Cc: Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============4052088718061590868==
Content-Type: multipart/alternative;
  boundary="Boundary-00=_0okJKc/9VHWl7sL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_0okJKc/9VHWl7sL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 02 June 2009, Jan Scholz wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Monday 01 June 2009, Jan Scholz wrote:
> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> 
> >> > On Friday 29 May 2009, Jan Scholz wrote:
> >> >> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> >> >> 
> >> >> >> We are too late in the cycle to revert this commit and it really is needed to
> >> >> >> fix a more serious issue.  Nevertheless knowing that it caused the problem to
> >> >> >> appear on your system is also important.
> >> >> >> 
> >> >> >> Ben, do you have an idea what may be going on here?  Does __disable_irq() mask
> >> >> >> the interrupt on this platform?
> >> >> >
> >> >> > I suppose so :-) I'll have to check what's going on, it's not
> >> >> > immediately clear to me.
> >> >> >
> >> >> > Cheers,
> >> >> > Ben.
> >> >> >
> >> >> >> 
> >> >> >> I'd like to see a boot log, preferably containing a suspend-resume in which
> >> >> >> the problem was reproduced.
> >> >> 
> >> >> Here is a log from booting, through several suspend cycles, until the
> >> >> trackpad disappeared. The first few suspends were done while X was
> >> >> running but from the console. As you can tell from lines like
> >> >>    May 28 23:51:26 [kernel] adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
> >> >> the trackpad was still present. The last suspend was done from within X,
> >> >> here the trackpad did not make it.
> >> >>    May 28 23:58:09 [kernel] adb devices: [2]: 2 c4 [7]: 7 1f
> >> >> However, there have been cases, although not in this log, were the
> >> >> trackpad has been alive even when suspending from within X.
> >> >
> >> > This means the problem is probably timing-related.
> >> >
> >> > Can you please try to comment out suspend_device_irqs() and
> >> > resume_device_irqs()  in drivers/base/power/main.c and see if that changes
> >> > anything?  It's not entirely safe (well, that's why the calls are there after
> >> > all), but hopefully the box won't hang during this test.
> >> >
> >> 
> >> Tried that against v2.6.30-rc7 and it seems to fix the issue. I did ~10
> >> suspend-resume cycles from the console (which worked just like before)
> >> and ~20 cycles from within X and the trackpad is still alive.
> >
> > So, it seems we lose and interrupt during resume and that confuses the
> > ADB controller driver or something like this.  Do you use the keyboard or
> > the trackpad as a wake-up device?
> 
> I do the wakeup by pressing keys on the keyboard. I'd try wakeup via the
> trackpad's button, but I have no idea how to activate that.
> 
> > Please additionally try to go back to the original code, put
> > 'sleepy_trackpad = 1' at the beginning of do_adb_reset_bus() in
> > drivers/macintosh/adb.c and see if the problem is reproducible with that.
> 
> Tried this, but it does not help.
> 
> What I haven't noticed before is, that even if the trackpad already
> disappeared, an additional suspend-resume cycle from the console brought
> it back to life every time. Sometimes this worked from within X as well,
> just not with such a high probability as from the console.
> However, this is independent from 'sleepy_trackpad = 1'. 

OK, the patch is below, but I haven't had the opportunity to test it yet.

Can you please check if it helps, on top of 2.6.30-rc8?

Best,
Rafael

---
 kernel/irq/manage.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6/kernel/irq/manage.c
===================================================================
--- linux-2.6.orig/kernel/irq/manage.c
+++ linux-2.6/kernel/irq/manage.c
@@ -187,9 +187,9 @@ static inline int setup_affinity(unsigne
 void __disable_irq(struct irq_desc *desc, unsigned int irq, bool suspend)
 {
 	if (suspend) {
-		if (!desc->action || (desc->action->flags & IRQF_TIMER))
-			return;
-		desc->status |= IRQ_SUSPENDED;
+		if (desc->action && !(desc->action->flags & IRQF_TIMER))
+			desc->status |= IRQ_SUSPENDED | IRQ_DISABLED;
+		return;
 	}
 
 	if (!desc->depth++) {
@@ -250,8 +250,12 @@ EXPORT_SYMBOL(disable_irq);
 
 void __enable_irq(struct irq_desc *desc, unsigned int irq, bool resume)
 {
-	if (resume)
+	if (resume) {
 		desc->status &= ~IRQ_SUSPENDED;
+		if (!desc->depth)
+			desc->status &= ~IRQ_DISABLED;
+		return;
+	}
 
 	switch (desc->depth) {
 	case 0:

--Boundary-00=_0okJKc/9VHWl7sL
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'Sans Serif'; font-size:11pt; font-weight:400; font-style:normal;"><table style="-qt-table-type: root; margin-top:2px; margin-bottom:2px; margin-left:4px; margin-right:4px;"><tr><td style="border: none;">On Tuesday 02 June 2009, Jan Scholz wrote:<br>
&gt; "Rafael J. Wysocki" &lt;rjw@sisk.pl&gt; writes:<br>
&gt; <br>
&gt; &gt; On Monday 01 June 2009, Jan Scholz wrote:<br>
&gt; &gt;&gt; "Rafael J. Wysocki" &lt;rjw@sisk.pl&gt; writes:<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &gt; On Friday 29 May 2009, Jan Scholz wrote:<br>
&gt; &gt;&gt; &gt;&gt; Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt; writes:<br>
&gt; &gt;&gt; &gt;&gt; <br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; We are too late in the cycle to revert this commit and it really is needed to<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; fix a more serious issue.  Nevertheless knowing that it caused the problem to<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; appear on your system is also important.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; <br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; Ben, do you have an idea what may be going on here?  Does __disable_irq() mask<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; the interrupt on this platform?<br>
&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt; I suppose so :-) I'll have to check what's going on, it's not<br>
&gt; &gt;&gt; &gt;&gt; &gt; immediately clear to me.<br>
&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt; Cheers,<br>
&gt; &gt;&gt; &gt;&gt; &gt; Ben.<br>
&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; <br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; I'd like to see a boot log, preferably containing a suspend-resume in which<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; the problem was reproduced.<br>
&gt; &gt;&gt; &gt;&gt; <br>
&gt; &gt;&gt; &gt;&gt; Here is a log from booting, through several suspend cycles, until the<br>
&gt; &gt;&gt; &gt;&gt; trackpad disappeared. The first few suspends were done while X was<br>
&gt; &gt;&gt; &gt;&gt; running but from the console. As you can tell from lines like<br>
&gt; &gt;&gt; &gt;&gt;    May 28 23:51:26 [kernel] adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f<br>
&gt; &gt;&gt; &gt;&gt; the trackpad was still present. The last suspend was done from within X,<br>
&gt; &gt;&gt; &gt;&gt; here the trackpad did not make it.<br>
&gt; &gt;&gt; &gt;&gt;    May 28 23:58:09 [kernel] adb devices: [2]: 2 c4 [7]: 7 1f<br>
&gt; &gt;&gt; &gt;&gt; However, there have been cases, although not in this log, were the<br>
&gt; &gt;&gt; &gt;&gt; trackpad has been alive even when suspending from within X.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; This means the problem is probably timing-related.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Can you please try to comment out suspend_device_irqs() and<br>
&gt; &gt;&gt; &gt; resume_device_irqs()  in drivers/base/power/main.c and see if that changes<br>
&gt; &gt;&gt; &gt; anything?  It's not entirely safe (well, that's why the calls are there after<br>
&gt; &gt;&gt; &gt; all), but hopefully the box won't hang during this test.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; Tried that against v2.6.30-rc7 and it seems to fix the issue. I did ~10<br>
&gt; &gt;&gt; suspend-resume cycles from the console (which worked just like before)<br>
&gt; &gt;&gt; and ~20 cycles from within X and the trackpad is still alive.<br>
&gt; &gt;<br>
&gt; &gt; So, it seems we lose and interrupt during resume and that confuses the<br>
&gt; &gt; ADB controller driver or something like this.  Do you use the keyboard or<br>
&gt; &gt; the trackpad as a wake-up device?<br>
&gt; <br>
&gt; I do the wakeup by pressing keys on the keyboard. I'd try wakeup via the<br>
&gt; trackpad's button, but I have no idea how to activate that.<br>
&gt; <br>
&gt; &gt; Please additionally try to go back to the original code, put<br>
&gt; &gt; 'sleepy_trackpad = 1' at the beginning of do_adb_reset_bus() in<br>
&gt; &gt; drivers/macintosh/adb.c and see if the problem is reproducible with that.<br>
&gt; <br>
&gt; Tried this, but it does not help.<br>
&gt; <br>
&gt; What I haven't noticed before is, that even if the trackpad already<br>
&gt; disappeared, an additional suspend-resume cycle from the console brought<br>
&gt; it back to life every time. Sometimes this worked from within X as well,<br>
&gt; just not with such a high probability as from the console.<br>
&gt; However, this is independent from 'sleepy_trackpad = 1'. <br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>OK, the patch is below, but I haven't had the opportunity to test it yet.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Can you please check if it helps, on top of 2.6.30-rc8?<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Best,<br>
Rafael<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>---<br>
 kernel/irq/manage.c |   12 ++++++++----<br>
 1 file changed, 8 insertions(+), 4 deletions(-)<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Index: linux-2.6/kernel/irq/manage.c<br>
===================================================================<br>
--- linux-2.6.orig/kernel/irq/manage.c<br>
+++ linux-2.6/kernel/irq/manage.c<br>
@@ -187,9 +187,9 @@ static inline int setup_affinity(unsigne<br>
 void __disable_irq(struct irq_desc *desc, unsigned int irq, bool suspend)<br>
 {<br>
 	if (suspend) {<br>
-		if (!desc-&gt;action || (desc-&gt;action-&gt;flags &amp; IRQF_TIMER))<br>
-			return;<br>
-		desc-&gt;status |= IRQ_SUSPENDED;<br>
+		if (desc-&gt;action &amp;&amp; !(desc-&gt;action-&gt;flags &amp; IRQF_TIMER))<br>
+			desc-&gt;status |= IRQ_SUSPENDED | IRQ_DISABLED;<br>
+		return;<br>
 	}<br>
 <br>
 	if (!desc-&gt;depth++) {<br>
@@ -250,8 +250,12 @@ EXPORT_SYMBOL(disable_irq);<br>
 <br>
 void __enable_irq(struct irq_desc *desc, unsigned int irq, bool resume)<br>
 {<br>
-	if (resume)<br>
+	if (resume) {<br>
 		desc-&gt;status &amp;= ~IRQ_SUSPENDED;<br>
+		if (!desc-&gt;depth)<br>
+			desc-&gt;status &amp;= ~IRQ_DISABLED;<br>
+		return;<br>
+	}<br>
 <br>
 	switch (desc-&gt;depth) {<br>
 	case 0:<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p></td></tr></table></body></html>
--Boundary-00=_0okJKc/9VHWl7sL--

--===============4052088718061590868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4052088718061590868==--
