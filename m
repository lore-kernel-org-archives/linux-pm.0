From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] CPUFreq PowerOP integration,
	Centrino PM Core and OPs registration 2/3
Date: Mon, 18 Sep 2006 12:46:24 +0200
Message-ID: <20060918104624.GB4973@elf.ucw.cz>
References: <45096C1A.7010008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45096C1A.7010008@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> +/* =

> + * FIXME: very temporary implementation, just to prove the concept !! =

> + */
> +static int =

> +process_pwr_param(struct pm_core_point *opt, int op, char *param_name,
> +		  int va_arg)

Ok, so can we get final implementation? Parsing strings in drivers is
evil...

									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
