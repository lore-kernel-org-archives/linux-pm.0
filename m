From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sun, 26 Dec 2010 07:27:15 +0200
Message-ID: <AANLkTin5=PJ35b0Oaj09wHDqR2h=Zb42WyV7Hy-BkAC5__24840.0535122075$1293341321$gmane$org@mail.gmail.com>
References: <AANLkTi=aHU57xDq+-DWrN2sJsAwx_9bZ_ofy1rOmp0VH@mail.gmail.com>
	<Pine.LNX.4.44L0.1012251046060.5079-100000@netrider.rowland.org>
	<AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
	<AANLkTikcTSgjdxR106H2XZdmepN40bTKfEgmP04OQAz3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikcTSgjdxR106H2XZdmepN40bTKfEgmP04OQAz3@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 25, 2010 at 11:50 PM, Vitaly Wool <vitalywool@gmail.com> wrote:
> you're talking about _complete_ shutdown as a suspended state for both
> runtime PM and static PM, is that correct?

Exactly.

This is the power of the card as seen by the MMC/SDIO subsystem.
