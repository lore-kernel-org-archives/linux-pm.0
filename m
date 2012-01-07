From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH 2/6] PM QoS: Add CPU frequency min/max as PM
 QoS params
Date: Sat, 07 Jan 2012 10:54:47 +0200 (EET)
Message-ID: <20120107.105447.73982038242397071.apm@brigitte.kvy.fi>
References: <20120106153027.GE12530@mgross-G62>
	<20120106.213236.1775053150950189700.apm@brigitte.kvy.fi>
	<20120107034746.GB3119@mgross-G62>
Reply-To: ananaza@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120107034746.GB3119@mgross-G62>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: mark gross <markgross@thegnar.org>
> On Fri, Jan 06, 2012 at 09:32:36PM +0200, Antti P Miettinen wrote:
>> mark gross <markgross@thegnar.org> writes:
[..]
>> > You should only have a cpu throughput qos.  I.e. FREQ_MIN.
>> > FWIW in my patch I named it : PM_QOS_CPU_THROUGHPUT  but, its just a
>> > different name to your PM_QOS_CPU_FREQ_MIN name.
>> 
>> I anticipated getting this comment :-)
> 
> I'm glad.  Say did we talk at plumbers last year?  This is starting to
> ring a bell.

Sorry - no, I've never been to plumbers :-)

> yes, there are a lot of interesting things one can do to attempt to
> somewhat gracefully deal with some sort of power or thermal envelope
> limitations.  But, they are not PM_QoS. 

Well - I'd say level of energy efficiency could easily be called PM
QoS, but taking the max out is easy enough.

	--Antti
