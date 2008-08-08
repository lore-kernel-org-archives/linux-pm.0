From: Pavel Machek <pavel@suse.cz>
Subject: Re: Tyan S2923-E suspend to ram fails to resume
Date: Fri, 8 Aug 2008 09:14:30 +0200
Message-ID: <20080808071430.GA10370__2619.75871767408$1218182113$gmane$org@ucw.cz>
References: <48977AF7.2070300@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <48977AF7.2070300@simon.arlott.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Simon Arlott <simon@fire.lp0.eu>
Cc: linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2008-08-04 22:56:07, Simon Arlott wrote:
> My system (Tyan S2923-E, dmesg attached) suspends ok in 
> all pm_test modes, but it won't resume with pm_test 
> "none".
> 
> [    6.423515] mem full: hash matches
> 
> When I press the power button, the port 80 display shows:
> FF D0 23 01 D0 ... DE
> (and again each time I press it)
> 
> If I force it to turn off, then on again:
> FF D0 23 01 D0 ... FF D0 23 01 D0 ... (D2?) D3 00 01 D5 
> D6 <normal boot>
> 
> Any ideas? (onboard SAS is disabled, watchdog is 
> disabled, everything else is enabled, PCI-E graphics 
> card)

Try verifying if it reaches assembly code under realmode/ ...


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
