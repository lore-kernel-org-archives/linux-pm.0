From: "Gross, Mark" <mark.gross@intel.com>
Subject: Re: [RFC] PowerOP Take 3, ARM OMAP1 platform support 3/5
Date: Wed, 26 Jul 2006 17:03:30 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D01F607FE@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
Cc: Matthew Locke <matt@nomadgs.com>, "Mochel,
	Patrick" <patrick.mochel@intel.com>, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org



>-----Original Message-----
>From: linux-pm-bounces@lists.osdl.org [mailto:linux-pm-bounces@lists.osdl.=
org] On Behalf Of David
>Brownell
>Sent: Sunday, July 23, 2006 9:25 AM
>To: linux-pm@lists.osdl.org
>Cc: Matthew Locke; Mochel, Patrick; sampsa.fabritius@nokia.com; linux@domi=
nikbrodowski.net
>Subject: Re: [linux-pm] [RFC] PowerOP Take 3, ARM OMAP1 platform support 3=
/5
>
>On Thursday 20 July 2006 1:01 pm, Eugeny S. Mints wrote:
>> +struct powerop_point {
>> +=A0=A0=A0=A0=A0=A0=A0unsigned int v; =A0 =A0 =A0 =A0 /* voltage in mV */
>> +=A0=A0=A0=A0=A0=A0=A0unsigned int dpll;=A0=A0=A0=A0=A0=A0/* in KHz */
>> +=A0=A0=A0=A0=A0=A0=A0unsigned int cpu;=A0=A0=A0=A0=A0=A0=A0/* CPU frequ=
ency in KHz */
>> +=A0=A0=A0=A0=A0=A0=A0unsigned int tc;=A0=A0=A0=A0=A0=A0=A0=A0/* in KHz =
*/
>> +=A0=A0=A0=A0=A0=A0=A0unsigned int per;=A0=A0=A0=A0=A0=A0=A0/* in KHz */
>> +=A0=A0=A0=A0=A0=A0=A0unsigned int dsp;=A0=A0=A0=A0=A0=A0=A0/* in KHz */
>> +=A0=A0=A0=A0=A0=A0=A0unsigned int dspmmu;=A0=A0=A0=A0/* in KHz */
>> +=A0=A0=A0=A0=A0=A0=A0unsigned int lcd;=A0=A0=A0=A0=A0=A0=A0/* in KHz */
>> +};
>
>A few comments:
>
> - This should be part of patch #4; it's not truly separate.
>
> - I take it "v" is CPU voltage rather than some random component?
>   Either way, there seems to be an omission here since boards
>   could have multiple voltages to care about ...

I think the components be exposed in a stand alone manner in addition to th=
e structure.  Also, could we have a driver module per element to expose eac=
h one to the system and user.  That way you can just load the drivers for t=
he control knobs you care about, and add more for your platform more easily.

>
> - In general, shouldn't an operating point be board-specific, so
>   that the parts of the system outside the SOC can be included?
>
> - I'd still rather see operating points be identified by a name
>   string of some kind so that the userspace API resembles that
>   of /sys/power/state:  just write the state name to that file.
>

What would you name an n-tuple of integers?  I can't think how this would w=
ork.

--mgross

>Still looking at the patches, otherwise.
>

Me too...
