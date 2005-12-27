From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Tue, 27 Dec 2005 16:55:18 -0500
Message-ID: <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
References: <20051227213439.GA1884@elf.ucw.cz>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051227213439.GA1884@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/27/05, Pavel Machek <pavel@ucw.cz> wrote:
>
>  static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
>  {
> -       return sprintf(buf, "%u\n", dev->power.power_state.event);
> +       if (dev->power.power_state.event)
> +               return sprintf(buf, "suspend\n");
> +       else
> +               return sprintf(buf, "on\n");
>  }

Are you sure that having only 2 options (suspend/on) is enough at the
core level? I could envision having more levels, like "poweroff", etc?

--
Dmitry
