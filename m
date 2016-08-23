From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/5] firmware: Add basic support for TI System Control
 Interface (TI-SCI) protocol
Date: Tue, 23 Aug 2016 13:38:14 -0500
Message-ID: <CAGo_u6oAU-4Gab2H5S6mRET8AoUMc+wGHofnK3BaZQzR-340JA@mail.gmail.com>
References: <20160819225159.10758-1-nm@ti.com>
 <20160819225159.10758-3-nm@ti.com>
 <5d03a04f-9184-10e4-43c9-8834e8a39545@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5d03a04f-9184-10e4-43c9-8834e8a39545@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, lkml <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Russ Dill <Russ.Dill@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <ssantosh@kernel.org>, dt list <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 21, 2016 at 11:20 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
[...]

>> +
>> +static int ti_sci_remove(struct platform_device *pdev)
>> +{
>> +     struct ti_sci_info *info;
>> +     int ret = 0;
>> +
>> +     info = platform_get_drvdata(pdev);
>> +
>> +     mutex_lock(&ti_sci_list_mutex);
>> +     if (info->users)
>> +             ret = -EBUSY;
>> +     else
>> +             list_del(&info->node);
>> +     mutex_unlock(&ti_sci_list_mutex);
>
> shouldn't the mbox channels be freed in remove?
>
> mbox_free_channel(info->chan_tx);
> mbox_free_channel(info->chan_rx);

Uggh.. yes.. my bad. thanks for catching this. will fix with a v2 next
week if there are no further comments.

--
Regards,
NIshanth Menon
