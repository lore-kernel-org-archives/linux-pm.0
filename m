From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 03/13] PM: Implement wakelock api.
Date: Tue, 10 Feb 2009 21:24:48 +0100
Message-ID: <20090210202448.GD1382@ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<20090206001020.GC19577@linux.intel.com>
	<d6200be20902051638p37fb012do8e0aad0e67cf4305@mail.gmail.com>
	<20090207003334.GA13923@linux.intel.com>
	<d6200be20902061647m4ca6e7bape70fe4b67685746c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902061647m4ca6e7bape70fe4b67685746c@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Fri 2009-02-06 16:47:59, Arve Hj?nnev?g wrote:
> On Fri, Feb 6, 2009 at 4:33 PM, mark gross <mgross@linux.intel.com> wrote:
> >> >> +#ifdef CONFIG_WAKELOCK_STAT
> >> >> +     create_proc_read_entry("wakelocks", S_IRUGO, NULL,
> >> >> +                             wakelocks_read_proc, NULL);
> >> >
> >> > Shouldn't we *not* be using /proc?  I think this should be under sysfs.
> >>
> >> It is not allowed under sysfs. Debugfs has been suggested, but we
> >> don't have debugfs mounted, and we include the wakelock stats in debug
> >> reports.
> >>
> >
> > why not under sysfs?
> 
> The rules for sysfs state that there should be one value or an array
> of values per file.

Yeah, so fix the wakelocks to be like that. echo "lock wakelock_name
3" > control_file is a wrong interface, anyway.

What about creating wakelocks with echo "3" > wakelock_name in special
directory?

And then you can use readdir in that directory to get your debugging
info...


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
