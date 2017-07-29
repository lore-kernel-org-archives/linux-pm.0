From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Ensure genpd name is set before creating
 debugfs entry
Date: Sat, 29 Jul 2017 10:04:50 +0200
Message-ID: <CAPDyKFo2tcteJAqR60dvfOwS361mA1yE+=ZxJEGB1GDW9szY+Q@mail.gmail.com>
References: <20170728184818.1306-1-d-gerlach@ti.com> <7c1b9c08-4b54-78ec-98da-ae10abd63dc7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7c1b9c08-4b54-78ec-98da-ae10abd63dc7@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 28 July 2017 at 20:55, Dave Gerlach <d-gerlach@ti.com> wrote:
> Hi,
> On 07/28/2017 01:48 PM, Dave Gerlach wrote:
>> Commit b6a1d093f96b ("PM / Domains: Extend generic power domain
>> debugfs") extends the existing generic power domain debugfs to provide
>> more information about each genpd, however it creates a debugfs
>> directory for each based on the name of the genpd. While it is a good
>> idea to populate the name field of each genpd, up until this commit it
>> was not required. However, attempting to call debugfs_create_dir with a
>> null name value causes a NULL pointer dereference panic.
>>
>> In order to keep things working as they did before the aforementioned
>> patch, check to see if name has been populated and if not, skip creating
>> the extended debugfs info path and warn that name is needed to get this
>> extended info.
>>
>> Fixes: b6a1d093f96b ("PM / Domains: Extend generic power domain debugfs")
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>
> As changelog describes, commit b6a1d093f96b ("PM / Domains: Extend generic power
> domain debugfs") currently causes a NULL pointer dereference panic if no name is
> assigned for a struct generic_pm_domain registered with the framework. Before
> this patch no name was required, so this patch is a first attempt to keep things
> that way and just warn the user that they can't get extended debugfs info
> without providing a genpd name.
>
> Of course a name is always a good idea, so I'm not sure if this patch is how we
> want to go about preventing this panic or perhaps just making the name mandatory
> and checking during probe, but I figured I'd kick the discussion off with a
> suggestion by sending this patch.

Instead of making it mandatory, why not assign ->name a generic name
(genpd0, genpd1, genpd2, etc ) in case it isn't set.

In that way, all debugfs prints using ->name, should at least show
something... and the bug you report should also be fixed..

Kind regards
Uffe
