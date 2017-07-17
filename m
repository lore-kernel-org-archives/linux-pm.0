From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2] PM / suspend: Add suspend_target_state()
Date: Mon, 17 Jul 2017 14:21:42 -0700
Message-ID: <2615c143-6cb2-1b89-d453-921306d665b6@gmail.com>
References: <20170716023610.4658-1-f.fainelli@gmail.com>
 <20170717200628.7018-1-f.fainelli@gmail.com> <20170717201631.GA13024@amd>
 <CAJZ5v0gJQHUMEXTbvb0q6rmW-1xuRWAwGMmo_CCE8mYj-xf5QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gJQHUMEXTbvb0q6rmW-1xuRWAwGMmo_CCE8mYj-xf5QA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 07/17/2017 02:03 PM, Rafael J. Wysocki wrote:
> On Mon, Jul 17, 2017 at 10:16 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> Hi!
>>
>>> Have the core suspend/resume framework store the system-wide suspend
>>> state (suspend_state_t) we are about to enter, and expose it to drivers
>>> via suspend_target_state() in order to retrieve that. The state is
>>> assigned in suspend_devices_and_enter().
>>
>> Do we really want to have variable + inline functions that just read
>> that variable?
> 
> Florian, Pavel is right, you can simply export the variable.
> 
> Anything accessing it should go under CONFIG_PM_SLEEP anyway.

Alright then, I will just export it. Stay tuned.
-- 
Florian
