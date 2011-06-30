From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH 8/9] OMAP: PM CONSTRAINTS: implement the
 devices wake-up latency constraints
Date: Thu, 30 Jun 2011 17:08:08 +0200
Message-ID: <BANLkTin0A8hYaL9-XB95vNyb8=YgPzDMBg__15103.5988856622$1309446839$gmane$org@mail.gmail.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
	<1308926286-30445-9-git-send-email-j-pihet@ti.com>
	<20110627183345.GA6187@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110627183345.GA6187@google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 27, 2011 at 8:33 PM, Todd Poynor <toddpoynor@google.com> wrote:
> On Fri, Jun 24, 2011 at 04:38:05PM +0200, jean.pihet@newoldbits.com wrote:
> ...
>> + =A0 =A0 /* Find the associated omap_device for dev */
>> + =A0 =A0 od =3D container_of(pdev, struct omap_device, pdev);
>> + =A0 =A0 if (!od || (od->hwmods_cnt !=3D 1)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: No unique hwmod for device =
%s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, dev_name(pm_qos_req->=
dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> Check for !od can be dropped... if there's a check for !pdev needed
> can add that, but container_of() won't return NULL for a valid
> contained field.
Ok fixed in the v2 version.

Thanks!
Jean


>
>
> Todd
>
