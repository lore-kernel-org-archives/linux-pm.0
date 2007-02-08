From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 04/10] powermac: clean up PIC initialisation
	code
Date: Thu, 8 Feb 2007 15:41:12 +1100
Message-ID: <17866.43496.243710.13852@cargo.ozlabs.ibm.com>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185836.479588000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070205185836.479588000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

Johannes Berg writes:
> This patch cleans up the powermac PIC initialisation code so that for G5
> powermacs we don't even compile the old pmac pic file.

On a 32-bit powermac config, with this patch I get:

  CC      arch/powerpc/platforms/powermac/mpic.o
/home/paulus/kernel/powerpc/arch/powerpc/platforms/powermac/mpic.c: In function ‘pmac_pic_setup_mpic_nmi’:
/home/paulus/kernel/powerpc/arch/powerpc/platforms/powermac/mpic.c:40: error: ‘xmon_action’ undeclared (first use in this function)
/home/paulus/kernel/powerpc/arch/powerpc/platforms/powermac/mpic.c:40: error: (Each undeclared identifier is reported only once
/home/paulus/kernel/powerpc/arch/powerpc/platforms/powermac/mpic.c:40: error: for each function it appears in.)
make[3]: *** [arch/powerpc/platforms/powermac/mpic.o] Error 1

Paul.
