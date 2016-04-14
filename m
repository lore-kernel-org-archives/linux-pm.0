From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 5/6] power: cros_usbpd-charger: Add EC-based USB PD
 charger driver
Date: Thu, 14 Apr 2016 11:35:57 +0200
Message-ID: <20160414093557.GA26596@amd>
References: <1457970301-24616-1-git-send-email-tomeu.vizoso@collabora.com>
 <1457970301-24616-6-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457970301-24616-6-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org


> +#define CHARGER_DIR_NAME		"CROS_USB_PD_CHARGER%d"
> +#define CHARGER_DIR_NAME_LENGTH		sizeof(CHARGER_DIR_NAME)
> +
> +#define MANUFACTURER_MODEL_LENGTH	32
> +
> +struct port_data {
> +	int port_number;
> +	char name[CHARGER_DIR_NAME_LENGTH];

That's not really correct, right? If we ever have more than 99 such
chargers...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
