From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [PATCH] PM / Hibernate: Improve performance of
 LZO/plain hibernation, checksum image
Date: Thu, 29 Dec 2011 14:54:59 +1100
Message-ID: <1325130899.2029.18.camel@shrek.rexursive.com>
References: <CAGsJ_4yXU62GZ38fe7TCH8uKLHJvZ8jtFbJLywqv1kgC7y9V_A@mail.gmail.com>
	<1325115628.2029.1.camel@shrek.rexursive.com>
	<CAGsJ_4xH-9MXq8UJJFLW=upBqK+PXbWfDJhttBN=n2_M0PzMSw@mail.gmail.com>
	<1325127531.2029.13.camel@shrek.rexursive.com>
	<CAGsJ_4x2yCNf48xnVzBCZLJhdUaAOfoNHx5AFamZMXgLZ0PEKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGsJ_4x2yCNf48xnVzBCZLJhdUaAOfoNHx5AFamZMXgLZ0PEKw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-12-29 at 11:20 +0800, Barry Song wrote:
> the platform is ARM cortex-a9 single-core 1Ghz SoC and we save image
> to a SD card or NAND.
> a phenomenon we saw is that multi-BIOs is not merged into a request by
> block level elevator. so the SD/NANDdisk driver handles many small
> request one page by one page. 

Interesting, thanks.

-- 
Bojan
