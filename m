From: "Peter Reid" <ppeter.reid@gmail.com>
Subject: Re: Dynamic Idle?
Date: Fri, 7 Nov 2008 21:07:19 +0530
Message-ID: <345163910811070737y7de8a4bfoa401b632d1db3162@mail.gmail.com>
References: <345163910811070501x4cafe0afq28c89898b771ec76@mail.gmail.com>
	<Pine.LNX.4.44L0.0811071003100.2437-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7952235065398134604=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0811071003100.2437-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============7952235065398134604==
Content-Type: multipart/alternative;
	boundary="----=_Part_47565_31103790.1226072239734"

------=_Part_47565_31103790.1226072239734
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Alan,


On Fri, Nov 7, 2008 at 8:36 PM, Alan Stern <stern@rowland.harvard.edu>wrote:

> On Fri, 7 Nov 2008, Peter Reid wrote:
>
> > What do the following terms mean in terms of linux power management for
> > embedded systems.
> >
> >  1) Dynamic - Idle
> >  2) Suspend-Resume
>
> Dynamic and Idle are two separate terms.  Dynamic means that something
> is running.  Idle means that something either isn't running or else is
> running but isn't doing anything.
>
> Suspend means to put either a single device or else the entire system
> into a non-operational low-power state.  Resume means to put the device
> or the system back into an operational full-power state.


  Do you mean to say that:

   Dynamic = Active
   Idle = Idle
   Suspend = Low Power State
   Resume = Active/Dynamic

  If so, what is the difference between suspend and Idle?

  Are both the same and what are OFF State/Retention State as well?


Thank you.

Regards,
Reid.








>
>
> > Could you please explain with a scenario of how these states occur in
> > real world embedded systems.
>
> Suppose an embedded system has a USB device attached.  At times when
> the device isn't being used, the system could put it into a low-power
> state to conserve energy.  When the system needs to use the device, it
> would first have to resume the device.
>
> Alan Stern
>
>

------=_Part_47565_31103790.1226072239734
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Alan,<br>&nbsp;<br><br><div class="gmail_quote">On Fri, Nov 7, 2008 at 8:36 PM, Alan Stern <span dir="ltr">&lt;<a href="mailto:stern@rowland.harvard.edu">stern@rowland.harvard.edu</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Fri, 7 Nov 2008, Peter Reid wrote:<br>
<br>
&gt; What do the following terms mean in terms of linux power management for<br>
&gt; embedded systems.<br>
&gt;<br>
&gt; &nbsp;1) Dynamic - Idle<br>
&gt; &nbsp;2) Suspend-Resume<br>
<br>
</div>Dynamic and Idle are two separate terms. &nbsp;Dynamic means that something<br>
is running. &nbsp;Idle means that something either isn&#39;t running or else is<br>
running but isn&#39;t doing anything.<br>
<br>
Suspend means to put either a single device or else the entire system<br>
into a non-operational low-power state. &nbsp;Resume means to put the device<br>
or the system back into an operational full-power state.</blockquote><div><br>&nbsp; Do you mean to say that:<br><br>&nbsp;&nbsp; Dynamic = Active<br>&nbsp;&nbsp; Idle = Idle<br>&nbsp;&nbsp; Suspend = Low Power State<br>&nbsp;&nbsp; Resume = Active/Dynamic<br><br>&nbsp; If so, what is the difference between suspend and Idle?<br>
<br>&nbsp; Are both the same and what are OFF State/Retention State as well?<br><br><br>Thank you.<br><br>Regards,<br>Reid.<br><br><br><br><br><br><br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<div class="Ih2E3d"><br>
&gt; Could you please explain with a scenario of how these states occur in<br>
&gt; real world embedded systems.<br>
<br>
</div>Suppose an embedded system has a USB device attached. &nbsp;At times when<br>
the device isn&#39;t being used, the system could put it into a low-power<br>
state to conserve energy. &nbsp;When the system needs to use the device, it<br>
would first have to resume the device.<br>
<font color="#888888"><br>
Alan Stern<br>
<br>
</font></blockquote></div><br>

------=_Part_47565_31103790.1226072239734--

--===============7952235065398134604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7952235065398134604==--
