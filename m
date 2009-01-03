From: Dmitry Nezhevenko <dion@inhex.net>
Subject: Re: [TuxOnIce-users] Shutdown troubles (probably
	about	nvidia)
Date: Sat, 3 Jan 2009 23:23:17 +0200
Message-ID: <20090103212317.GA10285__41375.8448827595$1231017975$gmane$org@laptop.local>
References: <20081231084723.GA13285@laptop.local>
	<20081231162819.GA8802@laptop.local> <20090103132604.GB1531@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090103132604.GB1531@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-users@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 03, 2009 at 02:26:05PM +0100, Pavel Machek wrote:
 
> If it is hard to reproduce w/o nvidia, maybe it is present in 2.6.25
> but hard to reproduce...?
> 
> Look for updated bios, and maybe ask nvidia for help...

This was a bit incorrect. I've successfully reproduced it without NVIDIA
blob. Probably bug was caused by updated BIOS. I can't currently revert
it. 

I've just filled bugreport against mainline kernel:
http://bugzilla.kernel.org/show_bug.cgi?id=12348
 
-- 
WBR, Dmitry
