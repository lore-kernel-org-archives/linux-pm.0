From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] power: Print wakeup_count instead of event_count in the
 sysfs attribute.
Date: Sun, 3 Jun 2018 10:05:26 +0200
Message-ID: <CAJZ5v0gWeq034sObmHsbJoiBri4a=Av8xroeuW+eqyv_W=cHjQ@mail.gmail.com>
References: <20180602023215.176521-1-ravisadineni@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180602023215.176521-1-ravisadineni@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, chenhong3@huawei.com, Pavel Machek <pavel@ucw.cz>, ravisadineni@google.com, Dmitry Torokhov <dtor@google.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tbroch@google.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rajat Jain <rajatja@google.com>, bleung@google.com
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 2, 2018 at 4:32 AM, Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
> Currently we show event_count instead of wakeup_count as part of per
> device wakeup_count sysfs attribute. Change it to wakeup_count to make
> it more meaningful.

More information, please.

In particular, why it is more meaningful.

Thanks,
Rafael
