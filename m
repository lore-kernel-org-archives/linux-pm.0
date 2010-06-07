From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] [RFC] Save/restore MISC_ENABLE register
Date: Mon, 7 Jun 2010 23:05:54 +0200
Message-ID: <201006072305.54829.rjw__13905.5463405841$1275944790$gmane$org@sisk.pl>
References: <201006071814.53583.linux@rainbow-software.org>
	<201006072051.10421.linux@rainbow-software.org>
	<4C0D4032.6020907@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C0D4032.6020907@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Len Brown <len.brown@intel.com>, Ondrej Zary <linux@rainbow-software.org>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 07 June 2010, H. Peter Anvin wrote:
> On 06/07/2010 11:51 AM, Ondrej Zary wrote:
> > 
> > Something like this?
> > 
> > Save/restore MISC_ENABLE register on suspend/resume.
> > This fixes OOPS (invalid opcode) on resume from STR on Asus P4P800-VM, which
> > wakes up with MWAIT disabled.
> > 
> > Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> > 
> 
> Yes, that's a lot better.
> 
> I presume you have tested it.  Rafael, do you want to take this or should I?

I can take it.  Is it OK to add your ACK?

Rafael
