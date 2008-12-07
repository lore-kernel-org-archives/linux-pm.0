From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
	and resume
Date: Sun, 7 Dec 2008 13:30:21 +0100
Message-ID: <200812071330.22030.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0812061324260.13426-100000@netrider.rowland.org>
	<alpine.LFD.2.00.0812062157590.3425@nehalem.linux-foundation.org>
	<s5hd4g4xqso.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7770337030714398191=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <s5hd4g4xqso.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

--===============7770337030714398191==
Content-Type: multipart/alternative;
  boundary="Boundary-01=_eH8OJjQFIPSF2xL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_eH8OJjQFIPSF2xL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Sunday, 7 of December 2008, Takashi Iwai wrote:
> At Sat, 6 Dec 2008 22:00:59 -0800 (PST),
> Linus Torvalds wrote:
> > 
> > 
> > 
> > On Sat, 6 Dec 2008, Arjan van de Ven wrote:
> > > 
> > > the problem is that the system bios can have reassigned interrupts
> > > after resume, and afaik we need to re-evaluate the ACPI methods to
> > > get the new mapping.
> > > So we need to unregister + re-register to make that happen
> > 
> > Can you give actual examples of real life situations?
> 
> There were such cases on intel8x0 and maestro3 on-board sound devices,
> but all they were about hibernate, IIRC.  Just though a quick git 
> log search, I found the following:
> 	http://bugzilla.kernel.org/show_bug.cgi?id=4416

Heh, I didn't remember _I_ had this issue. :-)

Well, I must admit my understanding of things at that time was not too clear ...

Anyway, the box is still available to me, so I'll check if that is still relevant.

Thanks,
Rafael

--Boundary-01=_eH8OJjQFIPSF2xL
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:11pt;font-family:Sans Serif">
<p>On Sunday, 7 of December 2008, Takashi Iwai wrote:</p>
<p>&gt; At Sat, 6 Dec 2008 22:00:59 -0800 (PST),</p>
<p>&gt; Linus Torvalds wrote:</p>
<p>&gt; &gt; </p>
<p>&gt; &gt; </p>
<p>&gt; &gt; </p>
<p>&gt; &gt; On Sat, 6 Dec 2008, Arjan van de Ven wrote:</p>
<p>&gt; &gt; &gt; </p>
<p>&gt; &gt; &gt; the problem is that the system bios can have reassigned interrupts</p>
<p>&gt; &gt; &gt; after resume, and afaik we need to re-evaluate the ACPI methods to</p>
<p>&gt; &gt; &gt; get the new mapping.</p>
<p>&gt; &gt; &gt; So we need to unregister + re-register to make that happen</p>
<p>&gt; &gt; </p>
<p>&gt; &gt; Can you give actual examples of real life situations?</p>
<p>&gt; </p>
<p>&gt; There were such cases on intel8x0 and maestro3 on-board sound devices,</p>
<p>&gt; but all they were about hibernate, IIRC.  Just though a quick git </p>
<p>&gt; log search, I found the following:</p>
<p>&gt; 	http://bugzilla.kernel.org/show_bug.cgi?id=4416</p>
<p></p>
<p>Heh, I didn't remember _I_ had this issue. :-)</p>
<p></p>
<p>Well, I must admit my understanding of things at that time was not too clear ...</p>
<p></p>
<p>Anyway, the box is still available to me, so I'll check if that is still relevant.</p>
<p></p>
<p>Thanks,</p>
<p>Rafael</p>
<p></p>
</body></html>
--Boundary-01=_eH8OJjQFIPSF2xL--

--===============7770337030714398191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7770337030714398191==--
