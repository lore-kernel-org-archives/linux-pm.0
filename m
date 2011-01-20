From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Resume from Memory very slow on 2.6.37+
Date: Thu, 20 Jan 2011 09:21:30 +0800
Message-ID: <AANLkTinvz=syQgiWkQLgu2ssutBNccKuyxdPcGj97npU__35030.7804103524$1295486585$gmane$org@mail.gmail.com>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
	<201101190238.18529.rjw@sisk.pl>
	<AANLkTimf3B=z1DCA2q+yi-ccyAJwmjkB_g8EP=ZTehmn@mail.gmail.com>
	<201101192219.07569.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101192219.07569.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 20, 2011 at 5:19 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> OK, I'd like you to test the two patches I'll send in replies to this
> message.
> [1/2] - It will go back to using ioremap_cache() for NVS pages allocation=
s.

Applied. This one makes resume effective.

> [2/2] - This one will move suspend_nvs_free() before device drivers' resu=
me
> =A0 =A0 =A0 =A0callbacks (should avoid conflicts with the drivers' mappin=
gs).

Applied. This one makes no difference. Without applying [1/2], this
one makes resume hangs, so definitely needs to go along with [1/2].

Applied both and I've tried a few cycles and resume still working ok.

Thanks,
Jeff
