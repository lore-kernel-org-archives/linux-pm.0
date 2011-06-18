From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 32 bit s2disk on 64 bit kernel
Date: Sat, 18 Jun 2011 12:44:09 +0200
Message-ID: <201106181244.09906.rjw@sisk.pl>
References: <4DFA1DA5.1010502@wasp.net.au> <201106172125.02276.rjw@sisk.pl>
	<4DFBF6EA.30609@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4DFBF6EA.30609@wasp.net.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, June 18, 2011, Brad Campbell wrote:
> On 18/06/11 03:25, Rafael J. Wysocki wrote:
> >>
> >> Scratch that. I compiled up suspend-utils on a 64 bit machine with an added -all-static ld flag and
> >> it's working great.
> >>
> >> I would have thought that with the proliferation of 64 bit procs in laptops that this configuration
> >> would be more prevalent, but perhaps I'm an oddball.
> >
> > Do you mean 32-bit user space with 64-bit kernel?
> 
> Yes.

It's not too common as far as I can tell.  User space can get some
advantage from 64-bitness too. :-)

> It turns out Virtualbox can't cope with a 32bit userspace on a 64bit kernel
> either (which is no bother as I now have a kvm capable CPU, and kvm copes nicely).
> 
> I have it working, but of course it's too much of a pain to get splashy & directfb
> and the rest of the playground fun to compile and link statically. The text screen
> is enough for me anyway.

Good, thanks for your feedback!

Rafael
