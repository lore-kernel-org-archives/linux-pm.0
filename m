From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.27-rc6: nohz + s2ram = need to press keys to get progress
Date: Fri, 12 Sep 2008 21:17:04 +0200
Message-ID: <200809122117.05750.rjw@sisk.pl>
References: <20080912083113.GA1625@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757461AbYILTMl@vger.kernel.org>
In-Reply-To: <20080912083113.GA1625@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Friday, 12 of September 2008, Pavel Machek wrote:
> Hi!
> 
> The old "you have to press keys to get machine to progress" seems to
> be back :-(. Thinkpad x60.

I guess the last bunch of HPET/clockevents patches caused that to happen.

We seem to be doing a "one step forward, one step back" thing here ...

Thanks,
Rafael
