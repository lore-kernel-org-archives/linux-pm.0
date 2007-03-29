From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Fri, 30 Mar 2007 02:11:47 +0800
Message-ID: <b6a2187b0703291111k67fcc904u8a225cbee8cf3e58@mail.gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	 <460BBD1B.4040308@ru.mvista.com>
	 <200703291531.18253.maximlevitsky@gmail.com>
	 <200703291546.48996.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <200703291546.48996.maximlevitsky@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@lists.osdl.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Jens Axboe <jens.axboe@oracle.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
List-Id: linux-pm@vger.kernel.org

On 3/29/07, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> Subject: Add suspend/resume for HPET
> This adds support of suspend/resume on i386 for HPET
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>

Confirmed that suspend/resume disk/ram works on X60s with
CONFIG_HPET_TIMER=y and CONFIG_NO_HZ unset.

But suspend to disk still hang with CONFIG_NO_HZ unset.

Thanks,
Jeff.
