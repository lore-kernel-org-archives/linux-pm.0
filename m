From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v3] thermal: tango: add resume support
Date: Wed, 24 Aug 2016 17:12:22 +0200
Message-ID: <57BDB956.8020709@free.fr>
References: <57726196.5060909@free.fr> <3377280.mzxhCYOnLL@wuerfel>
 <1472027140.2682.49.camel@intel.com> <2198269.vtL6N6bMEV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2198269.vtL6N6bMEV@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Sebastian Frias <sf84@laposte.net>, linux-pm <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On 24/08/2016 10:32, Arnd Bergmann wrote:

> I think the ideal is to have only one set of conditionals in each
> driver, so at least you don't get a mismatch between them.
> 
> SIMPLE_DEV_PM_OPS uses conditional evaluation (but does not
> show the reference to the compiler). Annotating the functions as
> __maybe_unused lets the compiler decide for itself if they should
> be dropped or not, which means we use only the conditional inside
> of SIMPLE_DEV_PM_OPS.
> 
> Ideally, SIMPLE_DEV_PM_OPS itself should have used an IS_ENABLED()
> check instead of the #ifdef, that would have made it possible to
> just leave the function always defined with no __maybe_unused, but
> still have it dropped from the object code without a warning
> when there is no runtime reference.

I'm not sure my trivial issue deserves this much discussion. I just
want the patch to be upstream in some form.

I'll submit one more patch, with SIMPLE_DEV_PM_OPS used unconditionally,
and annotate the resume function with __maybe_unused.

This will waste the space of the struct on systems where S3 is disabled,
but it seems to be the preferred solution, IIUC.

Regards.
