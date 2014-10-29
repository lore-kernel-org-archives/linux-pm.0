From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Runtime: Rework RPM get callback routines
Date: Wed, 29 Oct 2014 10:58:18 -0700
Message-ID: <7hd29aahc5.fsf@deeprootsystems.com>
References: <1413543482-12748-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413543482-12748-1-git-send-email-a.hajda@samsung.com> (Andrzej
	Hajda's message of "Fri, 17 Oct 2014 12:58:02 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Andrzej Hajda <a.hajda@samsung.com> writes:

> PM uses three separate functions to fetch RPM callbacks.
> These functions uses quite complicated macro in their body.
> The patch replaces these routines with one small macro and
> one helper function.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Acked-by: Kevin Hilman <khilman@linaro.org>
