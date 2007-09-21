From: Stefan Rompf <stefan@loplof.de>
Subject: Re: [RFC][PATCH 0/2 -mm] kexec based hibernation -v3
Date: Fri, 21 Sep 2007 10:43:37 +0200
Message-ID: <200709211043.38266.stefan__30351.175441365$1190363975$gmane$org@loplof.de>
References: <1190266440.21818.16.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190266440.21818.16.camel@caritas-dev.intel.com>
Content-Disposition: inline
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 20. September 2007 07:34 schrieb Huang, Ying:

> The hibernation procedure with the patch set is as follow:
>
> 1. Boot a kernel A
>
> 2. Work under kernel A
>
> 3. Kexec another kernel B (crash dump enabled) in kernel A.

>From a short glance over current Linus' arch/i386/kernel/machine_kexec.c, 
memory for the crash dump kernel B still needs to be reserved statically when 
booting A.

This is one of the biggest issues with kexec based hibernation. For the 
typical notebook user, it is totally unacceptable to reserve 16 megabytes of 
memory just to be able to suspend to disk. And given the fact that current 
distribution kernels are quite modular and require early module loading, even 
more memory might be needed.

IMHO, a plan how to fix this must exist or the concept of kexec based 
hibernation is a waste of time.

Stefan
