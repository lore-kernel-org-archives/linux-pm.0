From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] ahci: platform support for suspend/resume
Date: Thu, 17 Nov 2011 16:31:32 -0800
Message-ID: <CAN8TOE9T8YJ8Kbz=cuQ_CYPQozxU--yskZuBcXwe_emVVNQqDg__12568.4705483311$1321933359$gmane$org@mail.gmail.com>
References: <1321475279-29930-1-git-send-email-computersforpeace@gmail.com>
	<20111116203422.GA29581@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20111116203422.GA29581@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: balbi@ti.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

+linux-pm mailing list

Hi Felipe,

On Wed, Nov 16, 2011 at 12:34 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Nov 16, 2011 at 12:27:59PM -0800, Brian Norris wrote:
>> + =A0 =A0 /* Does platform support suspend/resume? */
>> + =A0 =A0 if (!pdata->suspend || !pdata->resume)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> should you really prevent suspend is platform doesn't provide
> ->suspend() ?

No, we shouldn't prevent suspend entirely; that would just be my
accidental side effect.

> I mean, we could some platform where all clocks are autogated and
> there's no need for platform to do anything. Would it be better to only
> call pdata->suspend if it exists but still let the AHCI-specific part go
> through ?

Perhaps. But would this have any unintended effects on systems that
don't implement AHCI power management at all? My intention was just to
provide an 'opt-in' interface for platform developers. I probably got
this wrong.

Brian
