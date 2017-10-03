From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 24/27] x86_32: assembly, add ENDs to some functions and
 relabel with SYM_CODE_*
Date: Tue, 3 Oct 2017 02:26:59 +0200
Message-ID: <CAJZ5v0j_mK4jXps2w=aZzjjM4Q2966htP8UEeoQAz-vNnHNB-Q@mail.gmail.com>
References: <20171002091246.28432-1-jslaby@suse.cz> <20171002091246.28432-24-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171002091246.28432-24-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Linux PM <linux-pm@vger.kernel.org>, xen-devel@lists.xenproject.org
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 2, 2017 at 11:12 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> All these are functions which are invoked from elsewhere, but they are
> not typical C functions. So we annotate them (as global) using the new
> SYM_CODE_START. All these were not balanced with any END, so mark their
> ends by SYM_CODE_END, appropriatelly.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: linux-pm@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org

For the hibernate part:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
