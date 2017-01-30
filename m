From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 1/3] system-power: Add system power and restart framework
Date: Mon, 30 Jan 2017 22:53:01 +0100
Message-ID: <20170130215301.GA18997@atrey.karlin.mff.cuni.cz>
References: <20170130171506.3527-1-thierry.reding@gmail.com>
 <20170130171506.3527-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33391 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbdA3VxD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 16:53:03 -0500
Content-Disposition: inline
In-Reply-To: <20170130171506.3527-2-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!


> +struct system_power_chip;
> +
> +struct system_power_ops {
> +	int (*restart)(struct system_power_chip *chip, enum reboot_mode mode,
> +		       char *cmd);
> +	int (*power_off_prepare)(struct system_power_chip *chip);
> +	int (*power_off)(struct system_power_chip *chip);
> +};
> +
> +struct system_power_chip {
> +	const struct system_power_ops *ops;
> +	struct list_head list;
> +	struct device *dev;
> +};

Is it useful to have two structures? AFAICT one would do.

Do we always have struct device * to work with? IMO we have nothing
suitable for example in the ACPI case. Would void * be more suitable?

Could you convert someting (acpi?) to the new framework as
demonstration?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
