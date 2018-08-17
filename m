From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2] console: Add console=auto option
Date: Fri, 17 Aug 2018 18:38:28 +0900
Message-ID: <20180817093828.GA10337@jagdpanzerIV>
References: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
 <20180816173902.18971-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180816173902.18971-1-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On (08/16/18 13:39), Prarit Bhargava wrote:
>
> +		auto	[X86] Enable ACPI SPCR console
			^^^^
			And arm64?


Any chance we can rename param to "spcr" or something more clear?
To explicitly state what exactly it's going to do. `auto' sounds
too general and doesn't tell me that much. I'm probably the only
here who can't see a connection between "auto" and "SPCR", but
still.

One more thing, as far as I can tell, acpi_parse_spcr() can fail
and return an error. arch_console_setup() hides all errors and
returns void. Should it return error code?

	int arch_console_setup(void)
	{
		return acpi_parse_spcr(false, true);
	}

Or maybe

	void arch_console_setup(void)
	{
		if (acpi_parse_spcr(false, true))
			pr_err(.........);
	}

There can be other consoles in the system, logging an error is not
such a useless thing.

	-ss
