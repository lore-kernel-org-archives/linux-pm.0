From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 32 bit s2disk on 64 bit kernel
Date: Fri, 17 Jun 2011 21:25:02 +0200
Message-ID: <201106172125.02276.rjw@sisk.pl>
References: <4DFA1DA5.1010502@wasp.net.au> <4DFA96CB.8080806@wasp.net.au>
	<4DFAC174.7040904@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4DFAC174.7040904@wasp.net.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 17, 2011, Brad Campbell wrote:
> On 17/06/11 07:50, Brad Campbell wrote:
> >>> I run an entirely 32 bit userspace on a 64bit kernel. I've compiled suspend-utils from todays git
> >>> tree. trying to use s2disk results in the following :
> >>>
> >>> Is this a supported configuration?
> >>
> >> No, it isn't.
> >
> > Hrm.. ok thanks for that. Back to tuxonice I guess.
> 
> Scratch that. I compiled up suspend-utils on a 64 bit machine with an added -all-static ld flag and 
> it's working great.
> 
> I would have thought that with the proliferation of 64 bit procs in laptops that this configuration 
> would be more prevalent, but perhaps I'm an oddball.

Do you mean 32-bit user space with 64-bit kernel?

Rafael
