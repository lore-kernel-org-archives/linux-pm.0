From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Wed, 31 Dec 2008 00:59:19 +0000 (GMT)
Message-ID: <348894.23448.qm__18305.3646506325$1230910618$gmane$org@web23108.mail.ird.yahoo.com>
References: <495A5FEC.5070608@lwfinger.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <495A5FEC.5070608@lwfinger.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Larry Finger <Larry.Finger@lwfinger.net>
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--- On Tue, 30/12/08, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> Alan Jenkins wrote:
> > That won't fix hibernation though.  The disconnect
> method can still get
> > called in resume from hibernation, before the
> workqueue gets unfrozen. 
> > To be honest, I'm far more interested in
> suspend-to-disk than
> > suspend-to-ram.
> 
> Does this patch fix your problem? It works here, but I only
> did one
> test. The patch is for wireless-testing.
> 
> Larry

My test is that STD works alright, but STR still does not work. I haven't tried STD for a long time - I mostly use STR with SUSPEND_MODULES -, so I have no idea if STD works before the patch or not. With the patch, I can suspend to RAM (removing my SUSPEND_MODULES workaround temporarily), but it would not "defrost - this is similiar to  my failed attempt at fixing this - adding some skeleton _suspend()/_resume() routines can get the driver to STR, but it won't defrost. Without any _suspend()/_resume() routines, it won't even suspend, but just spend ages trying to suspend.

I'll post your patch to http://bugzilla.kernel.org/show_bug.cgi?id=11887  as a work-in-progress...

Hin-Tak


      
