From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 16:09:55 -0700
Message-ID: <AANLkTikNu17rVaKgEPhaF41_p0BF3HO8yR6nPKLrpogE@mail.gmail.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<BLU102-W27964047CD70AACE5A24C9EBAE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W27964047CD70AACE5A24C9EBAE0@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 3, 2010 at 5:26 AM, Raj Kumar <rajkumar278@hotmail.com> wrote:
>
> Hi Arve and Alan,
>
> I have some questions regarding the Android early suspend and ACPI that a=
re
> as follows:
>
> 1) If i see the early suspend features which is for android, it is if the
> user presses power off
> the button and on button for late resumes. The question is if there is
> mobile platform,
> then when user presses power off button, will the early suspend handlers
> will be called
> at that time?
> what usecase android early suspend handles?
>

Early suspend is called on android when user-space turns the screen
off. It provides a central switch for user-space to turn off devices
that are not needed when the screen is off. The goal is to use
runtime-pm for this instead so the drivers don't have to be android
specific.

> 2) Regarding ACPI which is more bios centric, will the drivers need to
> implement suspend/resume
> as for normal OS use case scenarios?
>
> Regards
> Raj
>
>



-- =

Arve Hj=F8nnev=E5g
