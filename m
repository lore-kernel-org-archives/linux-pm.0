From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] device core: Add flag to autoremove device link on supplier unbind
Date: Tue, 26 Jun 2018 12:19:20 +0200
Message-ID: <6354476.UjADPVylrh@aspire.rjw.lan>
References: <20180530095704.5788-1-vivek.gautam@codeaurora.org> <541c84e9-47fc-e7bc-8249-1477b9e63455@codeaurora.org> <CAFp+6iGwcbOm0p33o9NEE7YBZNNvRsBeU0ySy0HcEmvq8mhBJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFp+6iGwcbOm0p33o9NEE7YBZNNvRsBeU0ySy0HcEmvq8mhBJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Greg KH <gregkh@linuxfoundation.org>, lukas@wunner.de, dmitry.torokhov@gmail.com, aspriel@gmail.com, Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 26, 2018 12:03:44 PM CEST Vivek Gautam wrote:
> On Wed, May 30, 2018 at 6:21 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> 
> Adding Ulf and Marek for their side of comments.
> In summary, we do not want to not maintain a device link pointer
> when adding a device link in supplier's driver, to delete the link later.
> An autoremove flag from the suppliers side (similar to what we already
> have for consumer side) can help autoremove the device link
> when supplier driver goes away.
> 
> Hi Rafael, Lukas,
> Gentle ping. Can you please consider reviewing this patch.

ISTR telling you that I didn't like the DL_FLAG_AUTOREMOVE_S name
as it is too similar to another existing flag.  That hasn't changed.

BTW, please CC the patch to linux-pm when you resend it.

Thanks,
Rafael
