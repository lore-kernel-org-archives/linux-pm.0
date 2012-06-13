From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [RFC] [PATCH 1/4] thermal: Use thermal zone device
	id in netlink messages
Date: Wed, 13 Jun 2012 06:57:06 +0300
Message-ID: <CAGF5oy9mJn-w_5p6O-Tsn97Vaqtk5voB_nY2BKjr5EPYGv9iXw@mail.gmail.com>
References: <1339507519-14434-1-git-send-email-eduardo.valentin@ti.com>
	<1339507519-14434-2-git-send-email-eduardo.valentin@ti.com>
	<4D68720C2E767A4AA6A8796D42C8EB59136298@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59136298@BGSMSX101.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello Durga,

On Tue, Jun 12, 2012 at 8:02 PM, R, Durgadoss <durgadoss.r@intel.com> wrote:
> Hi Eduardo,
>
>>
>> This patch changes the function thermal_generate_netlink_event
>> to receive a thermal zone device instead of a originator id.
>>
>> This way, the messages will always be bound to a thermal zone.
>
> I agree with you on this patch implementation.
>

Ok..

> But I am thinking most user space Apps today are using UEvent based
> mechanism, may be it is time for us to re-visit this implemention.
> There are standard UEvent parsers available which can be used.
> (instead of writing custom netlink parsing implementations)

Right... But do we have any legacy application relying on this netlink channel?

>
> I submitted this patch an year ago, (inspired by some acpi driver,
> which uses this same netlink mechanism) and have a couple of
> platforms using this. I can change them for my side.

Oh.. Ok.  Well, on my side, I don't really have any application
relying on it. I just want to make sure we don't break things while
changing the current implementation. If you are OK to change your
applications then fine. We can also, introduce the sysfs notify and
mark the netlink as deprecated, while the applications are being
modified. Then finally remove it.

>
> I don't know what other platforms are using this. Need Rui's
> help/suggestion here.

Indeed. Rui?

>
> Thanks,
> Durga

All best,

-- 

Eduardo Valentin
