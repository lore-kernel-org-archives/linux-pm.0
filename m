From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: Converting to dev_pm_ops (remove annoying warnings)
Date: Mon, 3 Aug 2009 12:15:13 +0900
Message-ID: <aec7e5c30908022015u4ec2489ex49bad474893c66f3__35055.1728312441$1249269384$gmane$org@mail.gmail.com>
References: <20090728104434.GA1728@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090728104434.GA1728@fluff.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Ben!

On Tue, Jul 28, 2009 at 7:44 PM, Ben Dooks<ben-linux@fluff.org> wrote:
> I have a couple of questions about changing drivers to use the
> dev_pm_ops method within drivers using the device driver model.
>
> 1) Should the suspend/resume code still be wrapped in #ifdef CONFIG_PM
> =A0 and supply a NULL 'struct dev_pm_ops' wen CONFIG_PM=3Dn
>
> 2) Is it allowable to submit changes to move drivers to dev_pm_ops
> =A0 during the -rc phase, or do we have to wait for the merge window
> =A0 before sending these? The number of warnings on a system that
> =A0 relies heavily on platform devices is annoying (S3C24XX ARM).

To begin with: I'm the one to blame for the annoying printouts. If
people dislike the printout then I'm all for disabling it later on in
the -rc phase. As you understand the goal is to motivate people to
update their drivers. =3D)

I'm not the right person to answer the merge policy question, but
wouldn't it be good to submit patches regardless of when they will be
picked up? OTOH, I guess knowing when helps if you have a bunch of
other changes queued up for your drivers though...

Any thoughts?

Cheers,

/ magnus
