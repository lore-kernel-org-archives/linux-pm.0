From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH 2/2] i2c: Factor out runtime suspend checks
 from PM operations
Date: Wed, 22 Dec 2010 20:40:23 +0530
Message-ID: <AANLkTi=KOq65TS299rB=K961=mVXnriyqNxdHzJey5rD__31575.0154587024$1293030802$gmane$org@mail.gmail.com>
References: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1292855593-30608-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1292855593-30608-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 20, 2010 at 8:03 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> =A0static int i2c_device_pm_restore(struct device *dev)
> @@ -267,7 +248,7 @@ static int i2c_device_pm_restore(struct device *dev)
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0if (pm)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm->restore ? pm->restore(dev) : 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_generic_restore(dev);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D i2c_legacy_resume(dev);

The full function is:

static int i2c_device_pm_restore(struct device *dev)
{
	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
	int ret;

	if (pm)
		ret =3D pm->restore ? pm->restore(dev) : 0;
	else
		ret =3D i2c_legacy_resume(dev);

	if (!ret) {
		pm_runtime_disable(dev);
		pm_runtime_set_active(dev);
		pm_runtime_enable(dev);
	}

	return ret;
}

Shouldn't you be deleting the pm_runtime_* stuff from here?  There is
already done in pm_generic_restore() iff the callback exists and returns
zero.
