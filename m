From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v7 1/6] base: power: runtime: Export pm_runtime_get/put_suppliers
Date: Tue, 13 Feb 2018 16:44:37 +0900
Message-ID: <CAAFQd5BmroRf-C8dQkvTKHWK1psGnNi1t7g-q=Xce6KjrGTsdw@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org> <1517999482-17317-2-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1517999482-17317-2-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Vivek,

On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> The device link allows the pm framework to tie the supplier and
> consumer. So, whenever the consumer is powered-on the supplier
> is powered-on first.
>
> There are however cases in which the consumer wants to power-on
> the supplier, but not itself.
> E.g., A Graphics or multimedia driver wants to power-on the SMMU
> to unmap a buffer and finish the TLB operations without powering
> on itself.

This sounds strange to me. If the SMMU is powered down, wouldn't the
TLB lose its contents as well (and so no flushing needed)?

Other than that, what kind of hardware operations would be needed
besides just updating the page tables from the CPU?

Best regards,
Tomasz
