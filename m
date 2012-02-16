From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Corrupted files after suspend to disk
Date: Thu, 16 Feb 2012 22:51:46 +0100
Message-ID: <201202162251.47063.rjw@sisk.pl>
References: <AANLkTinRC1hXvaXDVV5pOA4YyCdXwAjziZsDzm=LuHqK@mail.gmail.com>
	<CAFLxGvzzHDRma_Y_XEpOD+fY+vonbkoR1mvQp4Vb4c3M6fTsPA@mail.gmail.com>
	<20120216163030.GA32651@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120216163030.GA32651@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Jones <davej@redhat.com>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, esandeen@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thursday, February 16, 2012, Dave Jones wrote:
> On Thu, Feb 16, 2012 at 11:52:27AM +0100, richard -rw- weinberger wrote:
>  
>  > >> >> Of course, please test the above separately. :-)
>  > >> >
>  > >> > Ok, I'll test this when I'm at home.
>  > >> >
>  > >> > BTW: dropping the caches helps, when some files seem corrupted.
>  > >> > Today /usr/bin/okular was broken.
>  > >> > After setting vm.drop_caches=1 it worked again.
>  > >>
>  > >> On Linux 2.6.38 I'm unable to reproduce the issue.
>  > >> Only 2.6.37 seems to be affected.
>  > >> So, I'm moving over to 2.6.38. :)
>  > >
>  > Bad news:
>  > I saw the issue on 3.x too but thought it's because my IdeaPad s10 is crap.
>  > Now with my shiny new Lenovo x121e I have the same issue! :-(
>  > 
>  > OpenSUSE 12.1, kernel 3.2.7.
>  > After a few suspend2disk iterations random files are corrupted.
>  > But only cached files. A reboot solves the problem.
>  
> FWIW, we've been seeing a number of hard to diagnose failures
> with suspend to disk for the last few releases in Fedora.
> Eric Sandeen has been chasing https://bugzilla.redhat.com/show_bug.cgi?id=744275
> for a while, but there's no smoking gun that really explains what's
> getting into these states. Further complicating things, is that it
> doesn't seem to be 100% reproducable.

I wonder if that's reproducible with the filesystems freezing patch I posted
some time ago (it will need some rebasing to apply to the current mainline or
3.2.y).

I also thing that this problem discovered by Alan Stern may be involved:

http://marc.info/?l=linux-pm&m=132940331030253&w=4

Thanks,
Rafael
