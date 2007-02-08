From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 10/12] powerpc: remove unneeded exports in
	mem.c
Date: Thu, 8 Feb 2007 15:25:05 +1100
Message-ID: <17866.42529.436809.257415@cargo.ozlabs.ibm.com>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124614.830282000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070207124614.830282000@sipsolutions.net>
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
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Johannes Berg writes:

> arch/powerpc/mm/mem.c exports page_is_ram and phys_mem_access_prot which
> both are not used anywhere that could be modular.

phys_mem_access_prot is used in drivers/video/fbmem.c, and the fb
stuff can be a module.

Paul.
