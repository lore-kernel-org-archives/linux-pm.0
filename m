From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Re: [PATCH V5 1/2] Thermal: Add ST-Ericsson DB8500 thermal driver.
Date: Thu, 15 Nov 2012 19:02:27 +0800
Message-ID: <CAJLyvQw6D+3nuaOv=g6zKvBDzceWQzhDOxWE7RNt5xt3MsZ=8Q@mail.gmail.com>
References: <1352460548-3494-1-git-send-email-hongbo.zhang@linaro.com>
	<1352460548-3494-2-git-send-email-hongbo.zhang@linaro.com>
	<1352967218.2080.15.camel@rzhang1-mobl4>
	<CAJLyvQyu_oU7xx92JTOj6bvF+7-hOJfM=kTHj6JMogaYjC+Jww@mail.gmail.com>
	<1352970823.2080.22.camel@rzhang1-mobl4>
	<CAJLyvQxJeNgGc8sQiV_qmKCfvfWQKyR8S5ZMNCtETvJLMQH-oQ@mail.gmail.com>
	<CAKohponUGQNMvA0T1qhZbTGnK12upy4gcTPq4ZfZ-enLDbf4+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohponUGQNMvA0T1qhZbTGnK12upy4gcTPq4ZfZ-enLDbf4+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linaro-kernel@lists.linaro.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, amit.kachhap@linaro.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, "hongbo.zhang" <hongbo.zhang@linaro.com>
List-Id: linux-pm@vger.kernel.org

On 15 November 2012 18:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 15 November 2012 14:53, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> this is a driver for ST-Ericsson u8500 board(Snowball), with a ARM core inside.
>> so you should compile like this:
>> make  ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- u8500_defconfig
>> make  ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- uImage
>
> Then we must have a DEPENDS_ON in Kconfig entry for these.
Sorry for the negligence.
A V6 iteration has been sent out with "depends on ARCH_U8500" added.
Thank all of you.
>
>
> --
> viresh
