From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] [RFC] Save/restore MISC_ENABLE register
Date: Mon, 07 Jun 2010 11:53:38 -0700
Message-ID: <4C0D4032.6020907@zytor.com>
References: <201006071814.53583.linux@rainbow-software.org>
	<4C0D2BFB.2090200@zytor.com>
	<201006072051.10421.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006072051.10421.linux@rainbow-software.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Len Brown <len.brown@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 06/07/2010 11:51 AM, Ondrej Zary wrote:
> 
> Something like this?
> 
> Save/restore MISC_ENABLE register on suspend/resume.
> This fixes OOPS (invalid opcode) on resume from STR on Asus P4P800-VM, which
> wakes up with MWAIT disabled.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> 

Yes, that's a lot better.

I presume you have tested it.  Rafael, do you want to take this or should I?

	-hpa
