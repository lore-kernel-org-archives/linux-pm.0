From: Pavel Machek <pavel@suse.cz>
Subject: Re: PowerOp core patch
Date: Tue, 15 Aug 2006 19:02:31 +0000
Message-ID: <20060815190231.GG4032@ucw.cz>
References: <44D8D45F.80209@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44D8D45F.80209@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <dsingleton@mvista.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> -decl_subsys(power,NULL,NULL);
> +static ssize_t supported_states_show(struct subsystem * subsys, char * =

> buf)
> +{
> +       struct powerop *this, *next;
> +       struct list_head *head =3D &pm_states.list;
> +       const char *header =3D  "< Name >    <Frequency>  <Voltage>  =

> <Transition Latency>  < Description >\n";
> +       char * s =3D buf;
> +
> +       s +=3D sprintf(s, "%s", header);

This was NAKed before.

What is point in resending same broken patch again and again?
-- =

Thanks for all the (sleeping) penguins.
