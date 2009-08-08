From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 0/4] introduce device async actions
	mechanism
Date: Fri, 7 Aug 2009 17:29:05 -0700
Message-ID: <20090808005922.110A3526EA5__20833.5429466844$1249691500$gmane$org@mailhub.coreip.homeip.net>
References: <1248404514.2670.107.camel@rzhang-dt>
	<1249439048.2670.454.camel@rzhang-dt>
	<200908080222.03172.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908080222.03172.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 07 August 2009 17:22:03 Rafael J. Wysocki wrote:
> +       device_enable_async_pm(&i8042_platform_device->dev, true);
> +

Please don't do that, at least not right now. i8042 being the fine
piece of {soft,hard}ware as it is will not like when you start banging
on all its ports at the same time.

-- 
Dmitry
