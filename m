From: Greg KH <greg@kroah.com>
Subject: Re: PowerOP 1/3: PowerOP core
Date: Tue, 9 Aug 2005 00:32:35 -0700
Message-ID: <20050809073234.GB13203@kroah.com>
References: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82001034654388527=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Todd Poynor <tpoynor@mvista.com>
Cc: cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============82001034654388527==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2005 at 07:51:57PM -0700, Todd Poynor wrote:
> +static void powerop_kobj_release(struct kobject *kobj)
> +{
> +	return;
> +}

Hint, if your release function is just a noop like this, your code is
wrong.  The kernel requires you to have a release function for a reason.
Please fix it.

> +struct powerop_param_attribute {
> +	int index;
> +        struct attribute        attr;
> +};

space vs. tab issue.

> +static ssize_t
> +powerop_param_attr_show(struct kobject * kobj, struct attribute * attr,
> +			char * buf)
> +{
> +	struct powerop_param_attribute * param_attr = to_param_attr(attr);
> +	struct powerop_point point;
> +	ssize_t ret = 0;
> +
> +	if ((ret = powerop_get_point(&point)) == 0)
> +		ret = sprintf(buf, "%d\n", point.param[param_attr->index]);

Please break this up into 3 lines instead of 2 to make it easier to read
and maintain over time.

You do this in other places too, please fix them too.

thanks,

greg k-h

--===============82001034654388527==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82001034654388527==--
