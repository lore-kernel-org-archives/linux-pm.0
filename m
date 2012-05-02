From: mark gross <markgross@thegnar.org>
Subject: Plumbers: PM constraints micro-conf RFP
Date: Wed, 2 May 2012 07:36:10 -0700
Message-ID: <20120502143607.GA21640@G62>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mark gross <markgross@thegnar.org>, John Stultz <john.stultz@linaro.org>, jeen.pihet@G62.linuxfoundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>, "Agarwal, Ramesh" <ramesh.agarwal@intel.com>, Praveen Chidambaram <pchidamb@gmail.com>, Antti P Miettinen <amiettinen@nvidia.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>
Cc: paulmck@vnet.ibm.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a Request For Participation in a micro-conference at this years
Linux plumbers event.  For this micro conference to happen we need to
reach a certain critical mass WRT participants as measured by submitted
talks associated to Power Management Constraints.

The To: list is populated with folks that I've had interactions with
over extending pm-qos or constraint based PM over the past year.

If you are working on problems related to constraining the power /
performance of devices I am inviting your participation and request you
submit a proposal for presenting your problem space (preferred) and or
solution to a group of developers looking for a good solution to push
upstream.  The talks will be about 20 min long as I want to get into
some design and implementation discussions after the requirements
definition is mostly finished.

I am interested in gathering user mode interface needs as well as kernel
mode.

>From a high level pm-constraints is a generalization of pm-qos to include
limiting performance as well as its current limiting of device
throttling.

As performance limiting is typically used for any of the following:
1) staying within thermal operational envelopes
2) avoiding peak current
3) extending battery life in active use cases

I invite anyone working in any of these areas or pm-qos applications to
participate in this micro-conference.

I will organize the micro-conference into 2 parts:
1) problem statements with specific participant examples where
constraining the performance or throttling is needed.

2) high level design brain storming.

If the micro-conference happens (i.e. critical mass is reached) any
interested linux-plumbers attendees is very welcome to participate.

Please send me an off list email if you want me to add you to my mutt
alias of interested parties I'll use to cc people on emails.  Note: must
of the correspondence will cc linux-pm too.

Please submit a proposal if you are interested in participating in this
with me.  I know a number of people are working in this space for the
past few years now.  I think its a good time to compare notes and at
least consolidate requirements and use cases.  Perhaps we'll even come up
with a good design to implement in the process.

thanks,
--mark
