From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP take 3, PowerOP core 1/5
Date: Thu, 20 Jul 2006 15:01:30 -0700
Message-ID: <200607201501.32087.david-b@pacbell.net>
References: <c55240ed0607201250x5f77c473m381f1698f1168e52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <c55240ed0607201250x5f77c473m381f1698f1168e52@mail.gmail.com>
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
To: linux-pm@lists.osdl.org
Cc: Matthew Locke <matt@nomadgs.com>, patrick.mochel@intel.com, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

On Thursday 20 July 2006 12:50 pm, Eugeny S. Mints wrote:
> +static int __init powerop_init(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}
> +
> +static void __exit powerop_exit(void)
> +{
> +}
> +
> +module_init(powerop_init);
> +module_exit(powerop_exit);

Best to delete useless code like that.  :)

And you should be grabbing that mutex to register/unregister the arch
methods table, otherwise there's little point in having it ...
