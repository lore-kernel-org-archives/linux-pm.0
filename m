From: Todd Poynor <toddpoynor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Some thoughts on suspend/resume development
Date: Thu, 17 Mar 2005 11:45:35 -0800
Message-ID: <aeb6c9a30503171145572df59@mail.gmail.com>
References: <Pine.LNX.4.44L0.0503051036440.22405-100000@netrider.rowland.org>
	<Pine.LNX.4.50.0503080831160.31139-100000@monsoon.he.net>
	<1110341383.12485.57.camel@localhost.localdomain>
	<1110347090.3663.122.camel@desktop.cunningham.myip.net.au>
	<1110347981.12485.70.camel@localhost.localdomain>
	<Pine.LNX.4.50.0503090558080.9502-100000@monsoon.he.net>
	<20050309080158.3fcdb66f@cosmic.amd.com>
	<Pine.LNX.4.50.0503090656340.9502-100000@monsoon.he.net>
	<20050309154936.GA27835@cosmic.amd.com>
	<Pine.LNX.4.50.0503090750150.20138-100000@monsoon.he.net>
Reply-To: Todd Poynor <toddpoynor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.50.0503090750150.20138-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Mar 2005 07:52:29 -0800 (PST), Patrick Mochel
<mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org> wrote:
> 
> On Wed, 9 Mar 2005, Jordan Crouse wrote:
> 
> > On 09/03/05 06:57 -0800, Patrick Mochel wrote:
> > > What is "DPM"?
> >
> > http://dynamicpower.sourceforge.net
> 
> Fantastic. Montavista is again splintering development efforts?

If there's truly a concern over this, please be advised that language
at that site that hints at a broader purpose for investigating power
management of embedded systems long predates this forum, and I will
update the site to redirect folks interested in such issues to
linux-pm.

The DPM project is actually specifcally about interfaces for runtime
management of platform power parameters, a la cpufreq, with added
tidbits as embedded alternatives to the types of functions commonly
performed by acpid.  The original IBM and MontaVista developers did
previously discuss various aspects of DPM technology felt to be useful
for incorporation in standard Linux with the cpufreq developers but
these ideas did not gain acceptance at that time.  There are also
other aspects that have been specifically rejected by cpufreq
maintainers.  Hence this has lived on as an out-of-tree open source
project in the meantime, but yes, it is my job to attempt to gain
acceptance of certain features that would benefit all, and I will try
this soon.  This doesn't seem to be a particularly egregious example
of splintering in the long history of PM-related project forkage...

-- 
Todd
