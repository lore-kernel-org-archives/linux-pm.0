From: Pavel Machek <pavel@suse.cz>
Subject: Re: PM with rootfs on mmc?
Date: Fri, 2 Jan 2009 17:14:06 +0100
Message-ID: <20090102161406.GA1555@ucw.cz>
References: <8bf247760812302147i53ece31dx24a402cdeb6e28bd@mail.gmail.com>
	<alpine.LFD.2.00.0812310121520.17126@localhost.localdomain>
	<8bf247760812310732x6772b32fjf0ce5fdc25dea9bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8bf247760812310732x6772b32fjf0ce5fdc25dea9bc@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sriram V <vshrirama@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed 2008-12-31 21:02:06, Sriram V wrote:
> Hi,
>    Now, i am able to bring linux out of suspend. The problem was to do
> with the mmc card detection. With out card detection, The kernel used
> to hang when i tried to
> bring linux out of suspend.
> 
> The below works, if i boot out of NFS and mount sdmmc and do a
> 
> $ echo -n mem > /sys/power/state
> 
> However, If i boot out of SDMMC (rootfs on sdmmc). I am not able to
> bring it out of suspend.
> The kernel hangs.
> 
> I get the message:
> # echo -n mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> mmc0: card e624 removed

seems like mmc driver problem...  

(You may still have some fun if you fix that one with mmc
maintainers... because 'is it still same card' is difficult question,
but...)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
