From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regarding the dedicated memory for hibernation
Date: Tue, 22 Mar 2011 21:36:40 +0100
Message-ID: <201103222136.40903.rjw@sisk.pl>
References: <BLU102-W6F8402163EAD81AFBF321EB490@phx.gbl>
	<201011030418.02830.rjw@sisk.pl>
	<SNT117-W368129D3EED2DAB17547BFEBB40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <SNT117-W368129D3EED2DAB17547BFEBB40@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 22, 2011, Raj Kumar wrote:
> 
> Hi Rafael,
> 
> I have one question regarding the dedicated memory(the memory that is not OS addressable).

What do you mean by not OS addressable?

> But when userspace does mmap, I am creating mapping for VMA to physical addresses that are in dedicated memory.
> The question is when system hibernates, will the OS kernel take care of this when creating hibernation image as mmap creates a virtual address space or device driver should explicity swap this memory(dedicated memory) in hibernation image?

The hibernate core saves everything that's regarded as RAM.  The other memory
areas have to be saved by drivers (or generally subsystems) that manage them
before the image is created.

Thanks,
Rafael
