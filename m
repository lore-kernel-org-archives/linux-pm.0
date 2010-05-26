From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/5] Preallocate swap + minor fix.
Date: Wed, 26 May 2010 23:21:09 +0200
Message-ID: <201005262321.09971.rjw__20079.8435289927$1274916242$gmane$org@sisk.pl>
References: <4BFCC939.1000901@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BFCC939.1000901@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 May 2010, Nigel Cunningham wrote:
> Hi all.
> 
> In current in-kernel hibernation code, swap is allocated as the image is 
> being written.
> 
> The first four patches in this series rework things so that all swap 
> that will be used is allocated prior to any data being written to disk.
> The fourth patch might look like too much for one patch, but it's 
> necessary to not break bisecting.
> 
> The fifth patch fixes a minor error in displaying the speed at which I/O 
> occurred.
> 
> This is the beginning of what I hope will be a long series of sets of 
> patches, first working towards adding support for properly asynchronous 
> I/O (not batching, as is currently done), then compression, multiple 
> swap devices and more. In short, this is the beginning of work on 
> merging TuxOnIce functionality a bit at a time.
> 
> The work is coming now because I recently finished my previous job, so 
> I'm seeking to get some of those jobs I've been wanting to do for a long 
> time out of the way. If anyone wants to employ me to do this work, I 
> wouldn't say no! :)
> 
> Please excuse me if there are wrapping issues with the patches - I'm 
> using Thunderbird, and haven't sent a patch series for quite a while, so 
> don't remember the fancy git mailer way (will have to look it up).
> 
> Rafael, these and future patches will be available at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/nigelc/tuxonice-head.git#for-rafael

Thanks for the patches, I'll have a look at them as soon as I can.

I haven't replied to your hibernation algorithm idea, mostly because I didn't
have the time to look into it more thoroughly and I don't remember all of the
details.  I'm still going to reply to it, though.

Rafael
