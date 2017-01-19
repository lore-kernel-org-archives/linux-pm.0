From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] security: Change name of CONFIG_DEBUG_SET_MODULE_RONX
Date: Thu, 19 Jan 2017 12:34:06 +0100
Message-ID: <20170119113406.GC5110@osiris>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
 <1484789346-21012-3-git-send-email-labbott@redhat.com>
 <20170119111117.GB11176@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170119111117.GB11176@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, kernel-hardening@lists.openwall.com, Rob Herring <robh@kernel.org>, Jessica Yu <jeyu@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, "AKASHI,
 Takahiro" <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>, Len Brown <len.brown@intel.com>, Kees Cook <keescook@chromium.org>, linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Jason Wessel <jason.wessel@windriver>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 19, 2017 at 11:11:18AM +0000, Mark Rutland wrote:
> > +config HARDENED_MODULE_MAPPINGS
> > +	bool "Mark module mappings with stricter permissions (RO/W^X)"
> > +	default y
> > +	depends on ARCH_HAS_HARDENED_MODULE_MAPPINGS
> > +	help
> > +	  If this is set, module text and rodata memory will be made read-only,
> > +	  and non-text memory will be made non-executable. This provides
> > +	  protection against certain security vulnerabilities (e.g. modifying
> > +	  code)
> > +
> > +	  Unless your system has known restrictions or performance issues, it
> > +	  is recommended to say Y here.
> > +
> 
> I was hoping that we'd make this mandatory, as we'd already done for
> DEBUG_RODATA.

Same for s390: would be good to make this mandatory.
