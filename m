From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sat, 31 Jul 2010 21:52:14 -0700
Message-ID: <20100731215214.2543c07e__38825.4121215597$1280638399$gmane$org@infradead.org>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100731175841.GA9367@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Sat, 31 Jul 2010 10:58:42 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> o	"Power-aware application" are applications that are permitted
> 	to acquire suspend blockers on Android.  Verion 8 of the
> 	suspend-blocker patch seems to use group permissions to
> determine which applications are classified as power aware.
> 
> 	More generally, power-aware applications seem to be those that
> 	have permission to exert some control over the system's
> 	power state.

I don't like the term "Power aware application". An application is well
behaved or it isn't. "aware" has nothing to do with it.


> 
> REQUIREMENTS
> 
> o	Reduce the system's power consumption in order to (1) extend
> 	battery life and (2) preserve state until AC power can be
> obtained.

AC power is not relevant in discussions around power: Applications MUST
behave well, AC or DC both. Just ask any data center operator on how
much they run on DC and if he cares about power consumption.
Conversely, most mobile usages (both phone, tablet or netbook) are "DC
only"....





 
> o	It is necessary to be able to use power-naive applications.
> 	Many of these applications were designed for use in PC
> platforms where power consumption has historically not been of great
> 	concern, due to either (1) the availability of AC power or (2)
> 	relatively undemanding laptop battery-lifetime expectations.
> The system must be capable of running these power-naive applications
> 	without requiring that these applications be modified, and
> must be capable of reasonable power efficiency even when power-naive
> 	applications are available.

I don't buy this argument as is.

I do buy that there are many sloppy applications; mostly written quickly
for <appstore of the month>.  But most if not all of these are written
for the device in question (at least that is true for Apple and Android)
