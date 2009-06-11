From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 14:27:26 +0900
Message-ID: <aec7e5c30906102227o18ca40b9w90e889dbdb43464f__21040.4831254438$1244698101$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.0906101656100.2589-100000@iolanthe.rowland.org>
	<200906102331.14267.rjw@sisk.pl>
	<200906110115.30729.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906110115.30729.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 11, 2009 at 8:15 AM, Oliver Neukum<oliver@neukum.org> wrote:
> Am Mittwoch, 10. Juni 2009 23:31:13 schrieb Rafael J. Wysocki:
>> > > +/**
>> > > + * pm_check_children - Check if all children of a device have been
>> > > suspended. + * @dev: Device to check.
>> > > + *
>> > > + * Returns 0 if all children of the device have been suspended or
>> > > -EBUSY + * otherwise.
>> > > + */
>> >
>> > We might want to do a runtime suspend even if the device's children
>> > aren't already suspended. =A0For example, you could suspend a link whi=
le
>> > leaving the device on the other end of the link at full power --
>> > especially if powering down the device is slow but changing the link's
>> > power level is fast.
>>
>> Well, this means that the dependencies between devices in the device tree
>> are pretty much useless for the run-time PM as far as the core is
>> concerned. =A0In which case, why did you mention them at all?
>
> Some bussystems need this constraint others don't or only for some nodes.
> We need a way to communicate this to the core.

I agree that this depends on the bus.

Our SuperH on-chip SoC platform devices are arranged in a flat fashion
so no real problem there, but if there whould be dependencies then I
think we need to manage it recursively somehow.

Compare that to PM of our I2C driver and the I2C bus hanging off from
that. In that case I'd like to be able to autosuspend the I2C master
driver regardless of the I2C slave devices and their PM state.

/ magnus
