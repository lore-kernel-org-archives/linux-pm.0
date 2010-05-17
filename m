From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Mon, 17 May 2010 15:16:52 -0700
Message-ID: <87sk5qw4vf.fsf__39374.3511559025$1274134827$gmane$org@deeprootsystems.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005142308.48386.rjw@sisk.pl>
	<AANLkTilX0uhqrJtUSOC4smdH1M8V-h14J7YtRG4PPxOQ@mail.gmail.com>
	<201005172342.52660.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005172342.52660.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon\, 17 May 2010 23\:42\:52 +0200")
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:

>> =

>> How about:
>> =

>> PM: Add opportunistic suspend support.
>
> "PM: Opportunistic suspend support" would be sufficient IMO.
>
> Now, I'd start with the motivation.  Like "Power management features pres=
ent
> in the current mainline kernel are insufficient to get maximum possible e=
nergy
> savings on some platforms, such as Android, because ..." (here go explana=
tions
> why this is the case in your opinion).

Yes, this will be helpful.

> Next, "To allow Android and similar platforms to save more energy than th=
ey
> currently can save using the mainline kernel, introduce a mechanism by wh=
ich
> the system is automatically suspended (i.e. put into a system-wide sleep =
state)
> whenever it's not doing useful work, called opportunistic suspend".

Hopefully, a definition of "useful" will be given here, including by
what standards on-going work is determined not to be useful.

Kevin
