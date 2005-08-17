From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: PowerOP 0/3: System power operating point management
	API
Date: Tue, 16 Aug 2005 18:52:38 -0700
Message-ID: <43029866.8040605@mvista.com>
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com>
	<20050810100718.GC1945@elf.ucw.cz> <42FA796A.4080205@mvista.com>
	<20050809024907.GA25064@slurryseal.ddns.mvista.com>
	<Pine.LNX.4.50.0508091110430.19925-100000@monsoon.he.net>
	<42F963F6.60209@mvista.com>
	<20050809030000.GA25112@slurryseal.ddns.mvista.com>
	<20050816085345.GJ9150@dominikbrodowski.de>
	<20050816085740.GL9150@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050816085740.GL9150@dominikbrodowski.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, Todd Poynor <tpoynor@mvista.com>, cpufreq@lists.linux.org.uk, Patrick Mochel <mochel@digitalimplant.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Dominik Brodowski wrote:
> A small add-on:
> 
> We need to make sure that we're capable of handling smart CPUs like Transmeta
> Crusoe processors in a sane way. This means
> 
> 
>>b)	Setting of "values"
> 
> 
> is optional if the hardware itself can be set to a min/max value (step a
> above in previous mail).

Although I haven't looked into the Crusoe processor support, it may be 
that there is a different set of power parameters, not cpu speed 
directly, that are appropriate to manage on these platforms (after a 
brief look, seems to be a range of frequencies and some sort of flags)? 
  If so, these sorts of machine-specific power parameters are what 
PowerOP is trying to address, allowing management of the underlying 
machine-specific stuff to upper layers that may be presenting an 
abstracted view of power/performance, such as CPU speed or speed ranges, 
to the user.  Thanks,

-- 
Todd
