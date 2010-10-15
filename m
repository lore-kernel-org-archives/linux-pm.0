From: Sundar <sunder.svit@gmail.com>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Fri, 15 Oct 2010 21:34:53 +0530
Message-ID: <AANLkTin=nbO-bciv14o4PRQSizpCKyf-+e8xo3fdMu+P__7835.26620730317$1287158837$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1010140946030.1645-100000@iolanthe.rowland.org>
	<201010142100.58496.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010142100.58496.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 15, 2010 at 12:30 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>
>> There could be a new attribute file, or we could use a blank line
>> written to autosuspend_delay_ms for this purpose. =A0Either way, the
>> result would be to call pm_runtime_suspend. =A0If the device is idle,
>> merely awaiting the timer expiration for a scheduled suspend or
>> autosuspend, this would cause it to suspend immediately.
>

I personally think the blank line method is fine :). But yes, if we get
to hear something more from the Meego guys, then it would be more
better to fit everyone in.

Cheers!
