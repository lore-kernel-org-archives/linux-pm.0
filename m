From: Graeme Gregory <graeme@xora.org.uk>
Subject: Re: [PATCH] MAINTAINERS: add maintainers for arm64 acpi
Date: Wed, 5 Mar 2014 03:03:18 +0800
Message-ID: <20140304190318.GE28736@xora-yoga13>
References: <1393899345-7397-1-git-send-email-graeme.gregory@linaro.org>
 <1393899345-7397-2-git-send-email-graeme.gregory@linaro.org>
 <20140304102316.GG30596@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140304102316.GG30596@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 04, 2014 at 10:23:16AM +0000, Catalin Marinas wrote:
> On Tue, Mar 04, 2014 at 02:15:45AM +0000, Graeme Gregory wrote:
> > +ACPI ARM64
> 
> That's a pretty broad statement for a single file. Is it core support,
> architected peripherals, SoC?
> 
Hi Catalin would changing the title to ACPI ARM64 Core Support be better
in your mind. I do intend for the maintainership to cover just the
plat/arm-core.c file.

Graeme

> > +M:	Hanjun Guo <hanjun.guo@linaro.org>
> > +M:	Graeme Gregory <graeme.gregory@linaro.org>
> > +S:	Supported
> > +L:	linux-acpi@vger.kernel.org
> > +F:	drivers/acpi/plat/arm-core.c
> 
> This patch should be part of the series introducing the arm-core.c file
> and it will be ACKed (or NAKed) following review. We can't really commit
> maintainers to a file which does not exist in mainline and while there is
> still feedback to be addressed. It's like a blank cheque.
> 
> -- 
> Catalin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
