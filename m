From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [Bugme-new] [Bug 9555] New: Suspend to RAM
	horks keyboard autorepeat, system bell, trackpad
Date: Wed, 12 Dec 2007 23:03:36 -0800
Message-ID: <20071213070336.GA12252@kroah.com>
References: <bug-9555-10286@http.bugzilla.kernel.org/>
	<20071212183349.f81464bf.akpm@linux-foundation.org>
	<20071213064532.GA7618@shallowsky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071213064532.GA7618@shallowsky.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Akkana Peck <akkana@shallowsky.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, stable@kernel.org, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 12, 2007 at 10:45:32PM -0800, Akkana Peck wrote:
> The problem seems fixed in 2.6.24-rc5 (and I'd like to apologize for
> wasting everyone's time by not checking for a new version first).
> So the bug appeared in the patches that took 2.6.23.1 to 2.6.23.8, and
> was fixed by something between .23.8 and .24-rc5.
> 
> I'm fine with closing the bug since it's working fine in .24-rc5,
> but if anyone is curious what the problem was, I'm happy to help
> with tracking it down. It's very easily reproducible on this machine.

Yes, it would be nice to find out the 2.6.23 patch that caused this, so
we can revert it as people are still using the 2.6.23 tree :)

Can you do a bisection with the releases between 2.6.23.1 and 2.6.23.8
and see which release and then which patch caused this to happen?

thanks,

greg k-h
